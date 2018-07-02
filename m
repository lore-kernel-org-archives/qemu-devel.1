Received: from eggs.gnu.org ([2001:4830:134:3::10]:49131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3S3-0001Ll-7s
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3Ry-00005p-AU
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:21:27 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fa3Rx-000052-Vp
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:21:22 -0400
References: <20180702175030.18621-1-f4bug@amsat.org>
	<20180702175030.18621-6-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <53fedf79-0991-e8bb-8f04-3a75fd86c9fa@vivier.eu>
Date: Mon, 2 Jul 2018 20:20:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180702175030.18621-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 05/13] linux-user/strace: Improve
 settimeofday()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>

Le 02/07/2018 à 19:50, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-By: Guido Günther <agx@sigxcpu.org>
> ---
>  linux-user/strace.c    | 13 +++++++++++++
>  linux-user/strace.list |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
