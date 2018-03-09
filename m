Received: from eggs.gnu.org ([2001:4830:134:3::10]:42065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euO7v-0004Yc-VV
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euO7r-0001mG-4o
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:56:28 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:47525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euO7q-0001lx-Rj
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:56:23 -0500
References: <1c105562-7933-d6bf-1071-6836ad8b6e40@vivier.eu>
	<20180301111500.15717-1-shea@shealevy.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9c3d5a6f-e8e3-345c-4091-d54ee95d7ebe@vivier.eu>
Date: Fri, 9 Mar 2018 20:56:18 +0100
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

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
