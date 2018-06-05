Received: from eggs.gnu.org ([2001:4830:134:3::10]:36419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fQ28g-0008VV-SS
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 22:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fQ28c-0005GU-W7
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 22:56:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48584 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fQ28c-0005G7-Rb
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 22:55:58 -0400
Date: Tue, 5 Jun 2018 10:55:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180605025549.GB8708@lemon.usersys.redhat.com>
References: <20180604145109.30498-1-alex.bennee@linaro.org>
	<20180604145109.30498-6-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180604145109.30498-6-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 5/7] docker: Update fedora image to 28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: cota@braap.org, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org

On Mon, 06/04 15:51, Alex Benn=E9e wrote:
> From: Fam Zheng <famz@redhat.com>
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/fedora.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dock=
erfiles/fedora.docker
> index b706f42405..65d7761cf5 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -1,4 +1,4 @@
> -FROM fedora:27
> +FROM fedora:28
>  ENV PACKAGES \
>      ccache gettext git tar PyYAML sparse flex bison python3 bzip2 host=
name \
>      gcc gcc-c++ llvm clang make perl which bc findutils glib2-devel \
> --=20
> 2.17.0
>=20

This one is in master now.

Fam
