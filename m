Received: from eggs.gnu.org ([2001:4830:134:3::10]:59108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3Jn-0007UJ-H0
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3Jj-0000Hf-9G
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:48:39 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:44928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY3Jj-0000Gr-1k
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:48:35 -0400
Received: by mail-pl0-x241.google.com with SMTP id m16-v6so503712pls.11
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 22:48:34 -0700 (PDT)
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <db5a0c58-4087-61b4-2aab-6f2e96928120@linaro.org>
Date: Tue, 26 Jun 2018 22:48:30 -0700
MIME-Version: 1.0
In-Reply-To: <20180625124238.25339-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 02/46] vdi: Use definitions from
 "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, "open list:VDI" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>

On 06/25/2018 05:41 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
> ---
>  block/vdi.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
