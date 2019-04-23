Received: from eggs.gnu.org ([209.51.188.92]:57262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIymx-0008Eo-NT
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIymw-0007Py-SZ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:00:59 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:33223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIymw-0007Ou-LY
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:00:58 -0400
Received: by mail-pf1-x429.google.com with SMTP id h5so7804624pfo.0
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 10:00:58 -0700 (PDT)
References: <20190423102145.14812-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0ccf7480-4f78-14af-c03e-8c28e41b1e32@linaro.org>
Date: Tue, 23 Apr 2019 10:00:54 -0700
MIME-Version: 1.0
In-Reply-To: <20190423102145.14812-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/2] tcg: more tcg_gen_abs() uses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-ppc@nongnu.org

On 4/23/19 3:21 AM, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (2):
>   target/ppc: Use tcg_gen_abs_i32
>   target/tricore: Use tcg_gen_abs_tl

Queued onto tcg-vec-next.


r~
