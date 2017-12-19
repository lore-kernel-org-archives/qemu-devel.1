Received: from eggs.gnu.org ([2001:4830:134:3::10]:41936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eRF3w-00083T-8B
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eRF3q-0008SF-Dv
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:23:52 -0500
MIME-Version: 1.0
In-Reply-To: <20171219082518.19724-1-lma@suse.com>
References: <20171219082518.19724-1-lma@suse.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Dec 2017 11:23:43 +0100
Message-ID: <CAJ+F1CL-ohuLUdDvLC5GPZOX81tUMSXo_LkwNWFw47UEJ9ivWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build: Fix typo in scripts/git-submodule.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>
Cc: QEMU <qemu-devel@nongnu.org>, qemu trival <qemu-trivial@nongnu.org>

On Tue, Dec 19, 2017 at 9:25 AM, Lin Ma <lma@suse.com> wrote:
> Signed-off-by: Lin Ma <lma@suse.com>
> ---
>  scripts/git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> index bc7224a..807ca0b 100755
> --- a/scripts/git-submodule.sh
> +++ b/scripts/git-submodule.sh
> @@ -28,7 +28,7 @@ error() {
>      echo
>      echo "and then manually update submodules prior to running make, wit=
h:"
>      echo
> -    echo " $ scripts/git-sbumodule.sh update $modules"
> +    echo " $ scripts/git-submodule.sh update $modules"
>      echo
>      exit 1
>  }
> --
> 2.9.2


CC: trivial
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>
>



--=20
Marc-Andr=C3=A9 Lureau
