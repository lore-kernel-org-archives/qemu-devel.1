Received: from eggs.gnu.org ([2001:4830:134:3::10]:53975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1ecTwz-00044E-SH
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1ecTww-0002MF-7s
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:31:09 -0500
From: klim <klim.kireev@virtuozzo.com>
References: <20180112090122.1702-1-klim.kireev@virtuozzo.com>
Message-ID: <166e66d5-3d95-94d1-cba4-c637ecc0c94c@virtuozzo.com>
Date: Fri, 19 Jan 2018 13:30:54 +0300
MIME-Version: 1.0
In-Reply-To: <20180112090122.1702-1-klim.kireev@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/5 v3] preparation for Parallels Disk xml
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, stefanha@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On 01/12/2018 12:01 PM, Klim Kireev wrote:

ping
> Parallels Desktop and Parallels Cloud Server uses images glued with the
> bundle description in XML format. This series contains very basic
> description of this XML files and makes preparations for actual
> implementation to be followed.
>
> Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
>
> Changelog:
>
> v2:
> PATCH 1/5: Fix some places noticed by Stefan Hajnoczi <stefanha@redhat.com>
> PATCH 2/5: Rebase to upstream
> PATCH 3/5: Fix includes
>
> v3:
> PATCH 1/5: Fix the place about GUID, add emails of the authors
>
