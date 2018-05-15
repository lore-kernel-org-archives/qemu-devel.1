Received: from eggs.gnu.org ([2001:4830:134:3::10]:34065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fId3K-0008VL-On
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fId3G-0000G9-Ph
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:43:54 -0400
References: <1526401580-20535-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9e5b3375-7949-e409-9047-5d9e0f386198@redhat.com>
Date: Tue, 15 May 2018 11:43:49 -0500
MIME-Version: 1.0
In-Reply-To: <1526401580-20535-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qapi/net.json: Fix the version number of
 the "vlan" removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: qemu-trivial@nongnu.org

On 05/15/2018 11:26 AM, Thomas Huth wrote:
> "vlan" will be dropped in 2.13, not in 2.12. And while we're at it,
> use the better wording "dropped in" instead of "removed with" (also
> for the "dump" removal).
> 
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   qapi/net.json | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
