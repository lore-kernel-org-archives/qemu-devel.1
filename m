Received: from eggs.gnu.org ([2001:4830:134:3::10]:37309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cVZPb-0005rx-Ov
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cVZPX-0003qo-Sk
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:51:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cVZPX-0003q4-MU
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:51:31 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2C49624A8
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 07:51:29 +0000 (UTC)
References: <1485150895-19753-1-git-send-email-thuth@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <3e4f58c7-6f03-92ba-f794-31e95b932b6c@redhat.com>
Date: Mon, 23 Jan 2017 09:51:22 +0200
MIME-Version: 1.0
In-Reply-To: <1485150895-19753-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] MAINTAINERS: Add an entry for
 hw/core/null-machine.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

On 01/23/2017 07:54 AM, Thomas Huth wrote:
> The "Machine core" section sounds like a good match for this file.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b5ebfab..5be2033 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -813,6 +813,7 @@ M: Eduardo Habkost <ehabkost@redhat.com>
>  M: Marcel Apfelbaum <marcel@redhat.com>
>  S: Supported
>  F: hw/core/machine.c
> +F: hw/core/null-machine.c
>  F: include/hw/boards.h
>
>  Xtensa Machines
>

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
