Received: from eggs.gnu.org ([2001:4830:134:3::10]:59498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIEz7-0004La-2d
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIEz3-0005vB-6A
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:01:57 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:46730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIEz3-0005uU-0V
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:01:53 -0400
Received: by mail-pf0-x241.google.com with SMTP id p12-v6so6145759pff.13
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 08:01:52 -0700 (PDT)
References: <20180512003217.9105-1-richard.henderson@linaro.org>
	<20180512003217.9105-4-richard.henderson@linaro.org>
	<87r2mgowbl.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a8d7eff-63ab-bbff-c9cb-4a757fc149d5@linaro.org>
Date: Mon, 14 May 2018 08:01:47 -0700
MIME-Version: 1.0
In-Reply-To: <87r2mgowbl.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 03/11] target/arm: Implement FCVT
 (scalar, integer) for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-stable@nongnu.org

On 05/13/2018 12:21 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Cc: qemu-stable@nongnu.org
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Hmm oddly this fails to apply:

Did try vs master or target-arm.next (as mentioned in the cover)?


r~
