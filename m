Received: from eggs.gnu.org ([209.51.188.92]:52718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIwrJ-0003ln-Mt
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIwrI-0008Lc-H0
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:57:21 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:33638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIwrI-0008JK-7R
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:57:20 -0400
Received: by mail-pg1-x533.google.com with SMTP id k19so7747325pgh.0
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 07:57:19 -0700 (PDT)
References: <20190423102145.14812-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7319f017-da46-a2ec-ff9d-29987c2d0999@linaro.org>
Date: Tue, 23 Apr 2019 07:57:15 -0700
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
> Hi Richard, 2 patches to complete your series.
> 
> Based on Richard's "tcg vector improvements" series:
> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03430.html
> 
> Regards,
> 
> Phil.
> 
> Based-on: <20190420073442.7488-1-richard.henderson@linaro.org>

Thanks!  It's hard to track down all uses like this.  ;-)


r~
