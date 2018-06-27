Received: from eggs.gnu.org ([2001:4830:134:3::10]:35072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYFXX-0000gF-59
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYFXU-0000aS-3c
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:51:39 -0400
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-46-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b087cd95-c790-fa85-228b-89cf59c8c3bb@vivier.eu>
Date: Wed, 27 Jun 2018 20:50:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180625124238.25339-46-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 45/46] linux-user: Use the IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, Eric Blake <eblake@redhat.com>
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org

Le 25/06/2018 à 14:42, Philippe Mathieu-Daudé a écrit :
> It eases code review, unit is explicit.
> 
> Patch generated using:
> 
>   $ git grep -n '[<>][<>]= ?[1-5]0'
> 
> and modified manually.
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
