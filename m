Received: from eggs.gnu.org ([2001:4830:134:3::10]:37922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5qK4-0000X7-V4
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5qK4-0000ZQ-9S
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:16:20 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:43809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5qK4-0000Y0-44
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:16:20 -0400
Received: by mail-pf0-x22d.google.com with SMTP id j2so7890821pff.10
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 03:16:20 -0700 (PDT)
References: <20180410055912.934-1-richard.henderson@linaro.org>
	<CAFEAcA-UQhSMe4p8zDqXgW6qS6sadrrZaJFP9W0bVaimgTi0vw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3c5613ed-12bd-fe6d-a950-9128bf41bf3b@linaro.org>
Date: Tue, 10 Apr 2018 20:16:14 +1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-UQhSMe4p8zDqXgW6qS6sadrrZaJFP9W0bVaimgTi0vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] fpu: Fix rounding mode for
 floatN_to_uintM_round_to_zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 04/10/2018 05:40 PM, Peter Maydell wrote:
> Would this be likely the fix for
> https://bugs.launchpad.net/qemu/+bug/1761401
> ?

Yes indeed.


r~
