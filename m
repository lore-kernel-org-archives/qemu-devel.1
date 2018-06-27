Received: from eggs.gnu.org ([2001:4830:134:3::10]:59193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3K4-0007ce-KK
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3K1-0000Ue-LG
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:48:56 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:42348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY3K1-0000Tf-Gk
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:48:53 -0400
Received: by mail-pf0-x242.google.com with SMTP id w7-v6so467623pfn.9
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 22:48:53 -0700 (PDT)
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2f295850-cadf-953c-d32a-dc7ce0b9c140@linaro.org>
Date: Tue, 26 Jun 2018 22:48:49 -0700
MIME-Version: 1.0
In-Reply-To: <20180625124238.25339-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 01/46] include: Add IEC binary prefixes
 in "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 06/25/2018 05:41 AM, Philippe Mathieu-Daudé wrote:
> Loosely based on 076b35b5a56.
> 
> Suggested-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/qemu/units.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 include/qemu/units.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
