Received: from eggs.gnu.org ([2001:4830:134:3::10]:33481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWlxb-00025K-J0
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWlxX-0008L6-Iu
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:36:43 -0500
References: <20181207170733.129532-1-eblake@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <91a9ed54-0d57-b3f8-55b7-6c9589b232a8@vivier.eu>
Date: Tue, 11 Dec 2018 18:36:30 +0100
MIME-Version: 1.0
In-Reply-To: <20181207170733.129532-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] maint: Grammar fix to
 mailmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, berrange@redhat.com

Le 07/12/2018 à 18:07, Eric Blake a écrit :
> Make the sentence read better.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  .mailmap | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index ed8faa57192..b8e08297c90 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -34,6 +34,6 @@ Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-devel <qemu
> 
> 
>  # Also list preferred name forms where people have changed their
> -# git author config, or having utf8/latin1 encoding issues.
> +# git author config, or had utf8/latin1 encoding issues.
>  Daniel P. Berrangé <berrange@redhat.com>
>  Reimar Döffinger <Reimar.Doeffinger@gmx.de>
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
