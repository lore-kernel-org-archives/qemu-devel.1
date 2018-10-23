Received: from eggs.gnu.org ([2001:4830:134:3::10]:44702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEwLp-0001N8-8R
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEwLj-0002pw-Md
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:04:01 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEwLe-0002id-1R
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:03:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id l6-v6so1644376wrt.1
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 06:03:49 -0700 (PDT)
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-5-richard.henderson@linaro.org>
	<3b14b958-980e-be28-48e1-ef5e8f71f38b@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4696aa48-af14-fc29-98e8-b6edd5f19b67@linaro.org>
Date: Tue, 23 Oct 2018 14:03:44 +0100
MIME-Version: 1.0
In-Reply-To: <3b14b958-980e-be28-48e1-ef5e8f71f38b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/7] target/riscv: Rename some argument
 sets in insn32.decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, palmer@sifive.com, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, mjc@sifive.com

On 10/23/18 1:21 PM, Philippe Mathieu-Daudé wrote:
> On 23/10/18 14:04, Richard Henderson wrote:
>> For format x, use &x for the argument set and @x for the extract.
>> This is less confusing than e.g. "arith" for format R.
> 
> With your S-o-b:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Oh no.  I fully expect these to be merged back into the original patch set:
http://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg04648.html

r~
