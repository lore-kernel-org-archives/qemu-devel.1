Received: from eggs.gnu.org ([2001:4830:134:3::10]:37068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gXibW-00028q-TA
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gXibT-0003pG-IX
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:13:50 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181213175154.5242-1-armbru@redhat.com>
References: <20181213175154.5242-1-armbru@redhat.com>
Date: Fri, 14 Dec 2018 09:13:42 +0100
Message-ID: <w51sgz0cyq1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Replace qdict_put() by
 qdict_put_obj() where appropriate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Thu 13 Dec 2018 06:51:54 PM CET, Markus Armbruster wrote:
> Patch created mechanically by rerunning:
>
>   $  spatch --sp-file scripts/coccinelle/qobject.cocci \
> 	    --macro-file scripts/cocci-macro-file.h \
> 	    --dir block --in-place
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
