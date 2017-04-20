Received: from eggs.gnu.org ([2001:4830:134:3::10]:46125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hossein.ajallooiean@epfl.ch>) id 1d1Ckh-0004l7-J7
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hossein.ajallooiean@epfl.ch>) id 1d1Ckd-0008Aa-Hs
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:08:07 -0400
Received: from smtp0.epfl.ch ([2001:620:618:1e0:1:80b2:e058:1]:36864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hossein.ajallooiean@epfl.ch>)
	id 1d1Ckd-00089I-87
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:08:03 -0400
From: Ajallooiean Hossein <hossein.ajallooiean@epfl.ch>
Date: Thu, 20 Apr 2017 14:07:54 +0000
Message-ID: <1492697274243.46100@epfl.ch>
References: <5a275226-bce0-4c8f-a708-063245cfe8f2@Spark>
	<583d86e4-dc32-ca67-6157-2b4c1654a758@ilande.co.uk>
	<1492680594151.52017@epfl.ch>
	<CAFEAcA8dows4s2MfpkK0ndMXXt3DgxBhqJCWJqpH1JCuieidiA@mail.gmail.com>,
	<20dcfe00-767a-4246-97d1-86f4cbf47de7@Spark>
In-Reply-To: <20dcfe00-767a-4246-97d1-86f4cbf47de7@Spark>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Just to add to the below:=0A=
=0A=
I'm configuring qemu with only one option "--target-list=3Dsparc64-softmmu"=
 =0A=
=0A=
see here for my configure output: =0A=
https://pastebin.com/sLShqF36=0A=
=0A=
thanks for the support=0A=
Hoss=0A=
________________________________________=0A=
From: Qemu-devel <qemu-devel-bounces+hossein.ajallooiean=3Depfl.ch@nongnu.o=
rg> on behalf of Ajallooiean Hossein <hossein.ajallooiean@epfl.ch>=0A=
Sent: Thursday, April 20, 2017 3:08 PM=0A=
To: Peter Maydell=0A=
Cc: Mark Cave-Ayland; qemu-devel@nongnu.org=0A=
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic=0A=
=0A=
Ive downloaded the rc4 link you posted for 2.9 and am using that. - vanilla=
 qemu=0A=
=0A=
And am getting the error with that version.=0A=
=0A=
Kindest regards=0A=
Hoss=0A=
=0A=
On 20 Apr 2017, 14:40 +0200, Peter Maydell <peter.maydell@linaro.org>, wrot=
e:=0A=
On 20 April 2017 at 10:29, Ajallooiean Hossein=0A=
<hossein.ajallooiean@epfl.ch> wrote:=0A=
Thanks for getting back to me so quickly.=0A=
=0A=
I can boot Sparc64 -- ONLY when using the qemu from package manager. suppos=
edly version 2.5=0A=
=0A=
but when building it myself (as i have some additions) - im getting this ke=
rnel error:=0A=
=0A=
Sanity check -- if you build a purely upstream QEMU without any=0A=
of your additions does it still have this kernel error?=0A=
=0A=
thanks=0A=
-- PMM=0A=
