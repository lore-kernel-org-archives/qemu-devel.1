Received: from eggs.gnu.org ([2001:4830:134:3::10]:55140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea4gB-0003TD-Oe
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 14:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea4g8-0008Si-Hh
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 14:07:51 -0500
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:39414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ea4g8-0008QR-BC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 14:07:48 -0500
Received: by mail-pg0-x22a.google.com with SMTP id z20so5138090pgv.6
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 11:07:47 -0800 (PST)
References: <20180110063337.21538-1-richard.henderson@linaro.org>
	<CAFEAcA_yQPCNWcv0Mz9mKUObuQH74DcbzyBvo9=UWF6pJ0qPWg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <94742c6e-9b7c-2d83-fc97-b8813a96b1e8@linaro.org>
Date: Fri, 12 Jan 2018 11:07:44 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_yQPCNWcv0Mz9mKUObuQH74DcbzyBvo9=UWF6pJ0qPWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] target/arm: split out vfp_expand_imm
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

On 01/12/2018 09:22 AM, Peter Maydell wrote:
>> Richard Henderson (2):
>>   target/arm: Split out vfp_expand_imm
>>   target/arm: Add fp16 support to vfp_expand_imm
>>
>>  target/arm/translate-a64.c | 49 +++++++++++++++++++++++++++++++---------------
>>  1 file changed, 33 insertions(+), 16 deletions(-)
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> I could put these in target-arm.next now if you like ?

Yes, please.


r~
