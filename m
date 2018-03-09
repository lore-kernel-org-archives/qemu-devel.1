Received: from eggs.gnu.org ([2001:4830:134:3::10]:39733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euJXW-0007Yv-GD
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euJXR-0005m6-TE
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:02:34 -0500
References: <20180309104151.2431-1-apahim@redhat.com>
	<20180309104151.2431-3-apahim@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d264b51a-dc35-32ca-0adc-e79b1522e6de@redhat.com>
Date: Fri, 9 Mar 2018 09:02:04 -0600
MIME-Version: 1.0
In-Reply-To: <20180309104151.2431-3-apahim@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-iotests: set exec permission for
 tests lacking it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On 03/09/2018 04:41 AM, Amador Pahim wrote:
> Some tests are not executables. This patch sets the executable
> permission for those tests lacking that.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---

Duplicate of a patch already on Max's tree:
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg01167.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
