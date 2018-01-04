Received: from eggs.gnu.org ([2001:4830:134:3::10]:38229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWtBY-0008Nz-LG
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 19:15:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWtBT-0002Mc-Kc
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 19:15:04 -0500
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:43631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWtBT-0002MP-DI
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 19:14:59 -0500
Received: by mail-pg0-x232.google.com with SMTP id f18so31541pga.10
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 16:14:59 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-16-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <226d1a06-f65c-79e4-6097-94d2acd6944d@linaro.org>
Date: Wed, 3 Jan 2018 16:14:55 -0800
MIME-Version: 1.0
In-Reply-To: <1514940265-18093-16-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 15/21] RISC-V Spike Machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 01/02/2018 04:44 PM, Michael Clark wrote:
> +    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> +                            &error_abort);

Ah, right.  Nevermind my previous question.


r~
