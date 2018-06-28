Received: from eggs.gnu.org ([2001:4830:134:3::10]:36309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYewx-0005RP-6T
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYeww-0005LR-Dk
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:59:35 -0400
References: <20180628000745.4477-1-mreitz@redhat.com>
	<20180628000745.4477-7-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0c3cb310-3fcc-a2fa-4fa8-fa738718f6f1@redhat.com>
Date: Thu, 28 Jun 2018 16:59:27 -0500
MIME-Version: 1.0
In-Reply-To: <20180628000745.4477-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 06/31] iotests.py: Add filter_imgfmt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 06/27/2018 07:07 PM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 3 +++
>   1 file changed, 3 insertions(+)

Wow, we didn't need that before?  Matches what shell tests have.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
