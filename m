Received: from eggs.gnu.org ([2001:4830:134:3::10]:57331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTCso-000500-6f
	for Qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTCsn-0008B8-8Y
	for Qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:23:58 -0500
Received: from mail-ua0-x230.google.com ([2607:f8b0:400c:c08::230]:33709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTCsn-0008Av-4k
	for Qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:23:57 -0500
Received: by mail-ua0-x230.google.com with SMTP id i68so87934170uad.0
	for <Qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:23:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <22DFAEB4-7409-4ACC-93A3-901537CC1427@livius.net>
References: <6205DF8A-7643-432F-88FF-12B1E9DEF5D8@livius.net>
	<CAFEAcA_CDpXqAAJNdSQpk4MKOorDXqUi_AwsevrHk=pnbrS0NQ@mail.gmail.com>
	<277E72EB-288A-498F-9208-99EBF09218A6@livius.net>
	<CAFEAcA_54fL9YHVJLqAZS8p3OftGd-yq7C7k4jSfVGeCzwMPmA@mail.gmail.com>
	<D1505166-849A-439D-8E78-579F708D53BB@livius.net>
	<CAFEAcA-AB98qtJcrLQ=T4PDvg=VM2tTqxALVpZYoYQcd9fySFg@mail.gmail.com>
	<22DFAEB4-7409-4ACC-93A3-901537CC1427@livius.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 19:23:36 +0000
Message-ID: <CAFEAcA90TCXyHf6Lf6Vg-qBeGbT-zNQUBGSGZCOv1faA=qHJeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] CMSIS SVD based peripheral definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liviu Ionescu <ilg@livius.net>
Cc: QEMU Developer <Qemu-devel@nongnu.org>

On 16 January 2017 at 18:59, Liviu Ionescu <ilg@livius.net> wrote:
>
>> On 16 Jan 2017, at 20:17, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> "reading data that shipped with QEMU
>> and where QEMU won't work at all without it" (the data files
>> are clearly part of the program as a whole and the GPL
>> applies to them even if they don't happen to be binaries);
>
> I'm not a lawyer either, but isn't this case similar to packing
> binary modules with the Linux kernel?

Yes, and doing that is somewhere between "grey area" and
"GPL violation". Views of the kernel authors on that
topic if you want to dig into the detail:
http://www.tldp.org/HOWTO/Module-HOWTO/copyright.html
http://yarchive.net/comp/linux/gpl_modules.html

thanks
-- PMM
