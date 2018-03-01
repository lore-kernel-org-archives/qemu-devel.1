Received: from eggs.gnu.org ([2001:4830:134:3::10]:60919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1erMFk-0001Oz-4E
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:20:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1erMFf-0006CK-6B
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:20:00 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:37035)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1erMFe-0006Bx-SL
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:19:55 -0500
References: <1c105562-7933-d6bf-1071-6836ad8b6e40@vivier.eu>
	<20180301111500.15717-1-shea@shealevy.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <eba1112a-2aa2-781a-9597-7fe71eb50540@vivier.eu>
Date: Thu, 1 Mar 2018 12:19:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180301111500.15717-1-shea@shealevy.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] linux-user: Support f_flags in statfs
 when available.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shea Levy <shea@shealevy.com>, qemu-devel@nongnu.org

Le 01/03/2018 à 12:15, Shea Levy a écrit :
> Signed-off-by: Shea Levy <shea@shealevy.com>
> ---
>  linux-user/syscall.c      |  5 +++++
>  linux-user/syscall_defs.h | 41 +++++++++++++++++++----------------------
>  2 files changed, 24 insertions(+), 22 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
