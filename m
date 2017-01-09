Received: from eggs.gnu.org ([2001:4830:134:3::10]:35875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQdnc-0005qs-Rf
	for Qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQdnc-0000IH-2O
	for Qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:32:00 -0500
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:34672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQdnb-0000IA-V7
	for Qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:32:00 -0500
Received: by mail-ua0-x22f.google.com with SMTP id 35so33659455uak.1
	for <Qemu-devel@nongnu.org>; Mon, 09 Jan 2017 09:31:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <277E72EB-288A-498F-9208-99EBF09218A6@livius.net>
References: <6205DF8A-7643-432F-88FF-12B1E9DEF5D8@livius.net>
	<CAFEAcA_CDpXqAAJNdSQpk4MKOorDXqUi_AwsevrHk=pnbrS0NQ@mail.gmail.com>
	<277E72EB-288A-498F-9208-99EBF09218A6@livius.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 17:31:39 +0000
Message-ID: <CAFEAcA_54fL9YHVJLqAZS8p3OftGd-yq7C7k4jSfVGeCzwMPmA@mail.gmail.com>
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

On 9 January 2017 at 16:51, Liviu Ionescu <ilg@livius.net> wrote:
>> On 9 Jan 2017, at 18:16, Peter Maydell <peter.maydell@linaro.org> wrote:
>> The obvious issue that comes to mind
>> is licensing, though -- what licenses are the SVD files under,
>> and would those be compatible with QEMU's GPLv2 ?
>
> that's a common question with cmsis files. I could not find
> any specific license applying to svd files, so, since these
> files are provided as part of the arm cmsis packs, I would
> consider the generic license, which, starting with the latest
> cmsis release, was changed to Apache.

The FSF's view is that Apache 2.0 is not compatible with GPLv2:
https://www.gnu.org/licenses/license-list.html#apache2

thanks
-- PMM
