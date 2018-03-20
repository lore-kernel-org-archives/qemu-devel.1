Received: from eggs.gnu.org ([2001:4830:134:3::10]:54462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ey60u-0005hA-7p
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 21:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ey60p-0003MT-Oh
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 21:24:32 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:37930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ey60p-0003Lt-H8
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 21:24:27 -0400
Received: by mail-pf0-x241.google.com with SMTP id d26so1939pfn.5
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 18:24:27 -0700 (PDT)
References: <20180319115846.9662-1-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <78700c57-42b6-1538-438c-e1a5ed3c1302@linaro.org>
Date: Tue, 20 Mar 2018 09:24:22 +0800
MIME-Version: 1.0
In-Reply-To: <20180319115846.9662-1-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scripts/decodetree: Fix insnmask not
 marked as global in main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Peer Adelt <peer.adelt@hni.uni-paderborn.de>

On 03/19/2018 07:58 PM, Bastian Koppelmann wrote:
> if '-w 16' was given as a cmdline args a local copy of insnmask
> is set and not the global one.
> 
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
