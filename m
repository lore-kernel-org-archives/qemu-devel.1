Received: from eggs.gnu.org ([2001:4830:134:3::10]:42107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYFhs-0004Uk-WE
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 15:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYFhp-0003yb-TR
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 15:02:21 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:48326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fYFhp-0003wt-JD
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 15:02:17 -0400
References: <20180618184046.6270-1-richard.henderson@linaro.org>
	<20180618184046.6270-21-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7fddb066-3736-ab05-5fa8-411a232194fa@vivier.eu>
Date: Wed, 27 Jun 2018 21:02:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180618184046.6270-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 20/22] target/openrisc: Add support in
 scripts/qemu-binfmt-conf.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: shorne@gmail.com

Le 18/06/2018 à 20:40, Richard Henderson a écrit :
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  scripts/qemu-binfmt-conf.sh | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
