Received: from eggs.gnu.org ([2001:4830:134:3::10]:38380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cQe3C-0004C6-Lu
	for Qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cQe38-0006B1-6D
	for Qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:48:06 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1cQe37-0006Ap-Us
	for Qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:48:02 -0500
Received: by mail-wm0-x236.google.com with SMTP id c206so41851637wme.0
	for <Qemu-devel@nongnu.org>; Mon, 09 Jan 2017 09:48:01 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <CAFEAcA_54fL9YHVJLqAZS8p3OftGd-yq7C7k4jSfVGeCzwMPmA@mail.gmail.com>
Date: Mon, 9 Jan 2017 19:47:58 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1505166-849A-439D-8E78-579F708D53BB@livius.net>
References: <6205DF8A-7643-432F-88FF-12B1E9DEF5D8@livius.net>
	<CAFEAcA_CDpXqAAJNdSQpk4MKOorDXqUi_AwsevrHk=pnbrS0NQ@mail.gmail.com>
	<277E72EB-288A-498F-9208-99EBF09218A6@livius.net>
	<CAFEAcA_54fL9YHVJLqAZS8p3OftGd-yq7C7k4jSfVGeCzwMPmA@mail.gmail.com>
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


> On 9 Jan 2017, at 19:31, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> FSF's view is that Apache 2.0 is not compatible with GPLv2:

I can't dispute this, but does't the GPLv2 requirements apply to the =
qemu executable only? my JSON files are not compiled into the binary, =
but are data files, read by the executable when required. and anyway, =
the original license covers the original XML files, mine are not only =
JSON, but are also slightly different.


regards,

Liviu
