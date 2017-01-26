Received: from eggs.gnu.org ([2001:4830:134:3::10]:57684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWi21-0000RK-IE
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWi1w-0006zr-PT
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:15:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cWi1w-0006zJ-Jh
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:15:52 -0500
Date: Thu, 26 Jan 2017 19:15:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170126111548.GJ6879@lemon>
References: <20170124143346.22240-1-alex.bennee@linaro.org>
	<20170124143346.22240-8-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170124143346.22240-8-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/7] qemu-options: remove stray space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>

On Tue, 01/24 14:33, Alex Benn=E9e wrote:
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  qemu-options.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 80df52651a..55c68cecbb 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1705,7 +1705,7 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
>      "                old way to initialize a host network interface\n"
>      "                (use the -netdev option if possible instead)\n", =
QEMU_ARCH_ALL)
>  STEXI
> -@item -net nic[,vlan=3D@var{n}][,macaddr=3D@var{mac}][,model=3D@var{ty=
pe}] [,name=3D@var{name}][,addr=3D@var{addr}][,vectors=3D@var{v}]
> +@item -net nic[,vlan=3D@var{n}][,macaddr=3D@var{mac}][,model=3D@var{ty=
pe}][,name=3D@var{name}][,addr=3D@var{addr}][,vectors=3D@var{v}]
>  @findex -net
>  Create a new Network Interface Card and connect it to VLAN @var{n} (@v=
ar{n}
>  =3D 0 is the default). The NIC is an e1000 by default on the PC
> --=20
> 2.11.0
>=20
>=20

Reviewed-by: Fam Zheng <famz@redhat.com>
