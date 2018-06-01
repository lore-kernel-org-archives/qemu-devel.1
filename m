Received: from eggs.gnu.org ([2001:4830:134:3::10]:48517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOlSZ-0005bs-11
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOlSV-0005j9-Lp
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:55:19 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:47070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOlSV-0005iU-6D
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:55:15 -0400
Received: by mail-pf0-x234.google.com with SMTP id p19-v6so8400381pff.13
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 07:55:14 -0700 (PDT)
References: <1526945967-9687-1-git-send-email-cota@braap.org>
	<ff49bf54-3d5c-c2a4-95cd-3cb8c2efab51@linaro.org>
	<ada5eac5-eceb-b330-6f12-ac6e9c58268d@linaro.org>
	<87zi0ezwaw.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <11dad9ef-43ef-0ea3-7c87-aa43c43976f6@linaro.org>
Date: Fri, 1 Jun 2018 07:55:10 -0700
MIME-Version: 1.0
In-Reply-To: <87zi0ezwaw.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 00/17] tcg: tb_lock removal redux v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 06/01/2018 02:32 AM, Alex Bennée wrote:
>> I can invoke similar crashes with just about every image I try.
> 
> Just booting up?

Not even very far into the boot, and given that I can see it with coldfire,
even without -smp.


r~
