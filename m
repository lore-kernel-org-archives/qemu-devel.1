Received: from eggs.gnu.org ([2001:4830:134:3::10]:59795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cTF81-00019B-Qs
	for Qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:47:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cTF7x-0004P0-SR
	for Qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:47:49 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1cTF7x-0004Nj-L4
	for Qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:47:45 -0500
Received: by mail-wm0-x241.google.com with SMTP id d140so17451367wmd.2
	for <Qemu-devel@nongnu.org>; Mon, 16 Jan 2017 13:47:45 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <CAFEAcA90TCXyHf6Lf6Vg-qBeGbT-zNQUBGSGZCOv1faA=qHJeg@mail.gmail.com>
Date: Mon, 16 Jan 2017 23:47:39 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1C89BAB-F1E3-4E9F-8A23-CBCBD2768F31@livius.net>
References: <6205DF8A-7643-432F-88FF-12B1E9DEF5D8@livius.net>
	<CAFEAcA_CDpXqAAJNdSQpk4MKOorDXqUi_AwsevrHk=pnbrS0NQ@mail.gmail.com>
	<277E72EB-288A-498F-9208-99EBF09218A6@livius.net>
	<CAFEAcA_54fL9YHVJLqAZS8p3OftGd-yq7C7k4jSfVGeCzwMPmA@mail.gmail.com>
	<D1505166-849A-439D-8E78-579F708D53BB@livius.net>
	<CAFEAcA-AB98qtJcrLQ=T4PDvg=VM2tTqxALVpZYoYQcd9fySFg@mail.gmail.com>
	<22DFAEB4-7409-4ACC-93A3-901537CC1427@livius.net>
	<CAFEAcA90TCXyHf6Lf6Vg-qBeGbT-zNQUBGSGZCOv1faA=qHJeg@mail.gmail.com>
Subject: Re: [Qemu-devel] CMSIS SVD based peripheral definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developer <Qemu-devel@nongnu.org>


> On 16 Jan 2017, at 21:23, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> doing that is somewhere between "grey area" and
> "GPL violation".

too bad for GPL. :-(

the fact is that I'll continue to improve support for Cortex-M in my =
branch of QEMU, and the SVD definitions are part of it.

if you are not comfortable with it, no problem, it will remain a =
separate branch; by all means I'm not trying to force you to accept =
merging it into the mainstream.

if you don't mind, I'll continue to post messages regarding the progress =
of GNU ARM Eclipse QEMU to inform the other developers on the new =
solutions, to possibly save some duplicate efforts, and, hopefully, get =
some feedback.


regards,

Liviu



=20
