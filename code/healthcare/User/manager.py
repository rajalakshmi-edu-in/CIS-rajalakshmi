from django.contrib.auth.models import BaseUserManager

class UserManager(BaseUserManager):
    def create_user(self,email,name,phone,password=None):
        if not email:
            raise ValueError("Users must have an Email")
        if not name:
            raise ValueError("Users must have a Name")
        if not phone:
            raise ValueError("We require your Phone number")

        user = self.model(
                email = self.normalize_email(email),
                name = name,
                phone = phone
            )

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self,email,name,phone,password):
        user = self.create_user(

            email = self.normalize_email(email),
            name = name,
            phone = phone,
            password = password
            )

        user.is_admin = True
        user.is_superuser = True
        user.is_staff = True

        user.save(using=self._db)
        return user
