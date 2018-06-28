Received: from eggs.gnu.org ([2001:4830:134:3::10]:60294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYeZl-0004UA-3q
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYeZk-0005Au-AT
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:35:37 -0400
References: <20180628212544.21854-1-jsnow@redhat.com>
	<20180628212544.21854-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <888bb4da-4cdc-12d7-4149-82c9e1ac130d@redhat.com>
Date: Thu, 28 Jun 2018 16:35:29 -0500
MIME-Version: 1.0
In-Reply-To: <20180628212544.21854-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] iotests: add 222 to test basic
 fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 06/28/2018 04:25 PM, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/222     | 152 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/222.out |  66 ++++++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 219 insertions(+)
>   create mode 100644 tests/qemu-iotests/222
>   create mode 100644 tests/qemu-iotests/222.out

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
