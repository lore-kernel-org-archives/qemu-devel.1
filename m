Received: from eggs.gnu.org ([2001:4830:134:3::10]:51008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa55X-0000q0-7A
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa55W-0004RH-BI
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:06:19 -0400
References: <20180702194630.9360-1-jsnow@redhat.com>
	<20180702194630.9360-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c1d15937-1385-f68d-efaf-0e79305afc11@redhat.com>
Date: Mon, 2 Jul 2018 15:06:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180702194630.9360-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/2] iotests: add 222 to test basic
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 07/02/2018 02:46 PM, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/222     | 155 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/222.out |  67 ++++++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 223 insertions(+)
>   create mode 100644 tests/qemu-iotests/222
>   create mode 100644 tests/qemu-iotests/222.out

Reviewed-by: Eric Blake <eblake@redhat.com>

Since this iotest involves NBD, I'm fine including this series in my NBD 
queue; pull request to come before freeze.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
