Received: from eggs.gnu.org ([2001:4830:134:3::10]:42798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euOAW-0006ok-1O
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euOAR-00031Q-6r
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:59:08 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:60687)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euOAQ-000319-Sq
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:59:03 -0500
References: <20180228221609.11265-1-jcmvbkbc@gmail.com>
	<20180228221609.11265-11-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f6993c0c-0314-b942-20ac-d697c2e41c27@vivier.eu>
Date: Fri, 9 Mar 2018 20:58:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180228221609.11265-11-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 10/11] qemu-binfmt-conf.sh: add
 qemu-xtensa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 28/02/2018 à 23:16, Max Filippov a écrit :
> Register qemu-xtensa and qemu-xtensaeb for transparent linux userspace
> emulation.
> 
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  scripts/qemu-binfmt-conf.sh | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
