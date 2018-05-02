Received: from eggs.gnu.org ([2001:4830:134:3::10]:46000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1fDxB9-0000NZ-8S
	for qemu-devel@nongnu.org; Wed, 02 May 2018 15:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1fDxB5-0001lB-08
	for qemu-devel@nongnu.org; Wed, 02 May 2018 15:12:39 -0400
Received: from mail.ispras.ru ([83.149.199.45]:46176)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1fDxB4-0001jl-Je
	for qemu-devel@nongnu.org; Wed, 02 May 2018 15:12:34 -0400
In-Reply-To: <0P8400M5O5RWWW30@mr11p00im-asmtp003.me.com>
References: <0P8400M5O5RWWW30@mr11p00im-asmtp003.me.com>
MIME-Version: 1.0
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Wed, 02 May 2018 22:12:30 +0300
Message-ID: <8b1f4516-b85e-4d6f-af45-98136fb3b481@ispras.ru>
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v3 00/30] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominique Fuchs <d.fuchs91@icloud.com>
Cc: dovgaluk@ispras.ru, QEMU Developers <qemu-devel@nongnu.org>

I used --disable-capstone for building under Windows=2E

=E2=81=A3=D0=9E=D1=
=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE =D1=81 =D0=BF=D0=BE=D0=
=BC=D0=BE=D1=89=D1=8C=D1=8E BlueMail =E2=80=8B

=D0=9D=D0=B0 2 =D0=9C=D0=B0=
=D0=B9 2018 =D0=B3=2E, 21:24, =D0=B2 21:24, Dominique Fuchs <d=2Efuchs91@ic=
loud=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:=D0=BF>C:\msys64\min=
gw64\bin\ar=2Eexe: creating libfdt/libfdt=2Ea
>make[1]: *** No rule to make=
 target
>=E2=80=9E/home/Dominique/qemu/capstone/capstone=2Elib=E2=80=9C=2E =
 Stop=2E
>make: *** [Makefile:503: subdir-capstone] Error 2
>
>I just stumb=
led across the same error while building qemu 2=2E12 on
>MSYS2/mingw64, whi=
ch led me to this conversation from january=2E
>According to this list, the=
re was no final solution to this, as this
>still happens in build chain for=
 2=2E12 and no further comments were
>made=2E Did I miss something elsewher=
e?
>
>Dominique Fuchs
