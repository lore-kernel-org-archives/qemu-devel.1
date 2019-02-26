Received: from eggs.gnu.org ([209.51.188.92]:57534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyfhs-0000pJ-H3
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyfhq-0007SW-KN
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:35:48 -0500
References: <1551197495-24425-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <28063180-0e42-98ad-ba24-4676f436ff82@redhat.com>
Date: Tue, 26 Feb 2019 10:35:25 -0600
MIME-Version: 1.0
In-Reply-To: <1551197495-24425-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] iotests: handle TypeError for Python 3
 in test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: nsoffer@redhat.com, mreitz@redhat.com, kwolf@redhat.com, ehabkost@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

On 2/26/19 10:11 AM, Andrey Shinkevich wrote:
> The data type for bytes in Python 3 differs from the one in Python 2.
> The type cast that is compatible with both versions was applied.
> 
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

Will include this in my v2 pull request.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
