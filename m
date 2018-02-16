Received: from eggs.gnu.org ([2001:4830:134:3::10]:55544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emmrm-0003Mn-Lp
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 15:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emmrl-0005DX-Un
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 15:44:22 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-8-git-send-email-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <29155e4e-9a6f-78e5-27ae-4eaef68c5d9c@redhat.com>
Date: Fri, 16 Feb 2018 14:44:15 -0600
MIME-Version: 1.0
In-Reply-To: <1518702707-7077-8-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/9] iotests.py: tiny refactor: move system
 imports up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/iotests.py | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

What breaks if they aren't moved?  But stylistically, this looks 
reasonable; and can be merged independently of NBD stuff if someone else 
wants.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
