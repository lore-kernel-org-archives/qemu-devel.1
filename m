Received: from eggs.gnu.org ([2001:4830:134:3::10]:42786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzKj0-0000VE-9I
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzKiv-0006LU-BY
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:51:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46444 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fzKiv-0006LF-5C
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:51:21 -0400
References: <f38111ad-3fbb-210e-e7ec-49ae675ea65e@eagerm.com>
	<a57fdd27-7a86-3f31-341c-e98101d17b9a@eagerm.com>
	<61c2239b-f8db-6648-ba1b-203309d876eb@eagerm.com>
	<f741c912-c37b-34a6-89a3-96577d186adc@eagerm.com>
	<CAFEAcA-8fF1F6A64Yv5G0LB9T4mBRvSSqi8oe3kENxSOGc982Q@mail.gmail.com>
	<26b3530a-d671-3ad8-dc51-101ab749dd40@eagerm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <84684513-3aec-7c09-0694-c18e6b1023b7@redhat.com>
Date: Mon, 10 Sep 2018 13:51:19 +0200
MIME-Version: 1.0
In-Reply-To: <26b3530a-d671-3ad8-dc51-101ab749dd40@eagerm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] RISC-V - Dynamic parameterization of
 RISC-V memory map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Eager <eager@eagerm.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 07/09/2018 02:21, Michael Eager wrote:
> It could also be extended to describe other processor features, for
> example, the number of cores.

The number of cores is already described via -smp, isn't it?

Paolo
