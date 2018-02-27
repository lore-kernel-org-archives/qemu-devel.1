Received: from eggs.gnu.org ([2001:4830:134:3::10]:45295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlky-0002A4-1a
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlkx-0001fF-5R
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:21:47 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-21-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b281a542-743e-1a92-3434-2c80fede86af@redhat.com>
Date: Tue, 27 Feb 2018 14:21:24 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-21-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 20/21] iotests: test manual job dismissal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

On 02/23/2018 05:51 PM, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/056     | 195 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/056.out |   4 +-
>   2 files changed, 197 insertions(+), 2 deletions(-)
> 

I'm not sure if this covers everything in the series, but it looks like 
a reasonable expansion and hits a lot of the highlights.  At any rate, 
it's always better to add tests, and the test passing is a good bet that 
the new code will be harder to regress.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
