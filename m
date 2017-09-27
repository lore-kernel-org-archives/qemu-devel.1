Received: from eggs.gnu.org ([2001:4830:134:3::10]:46862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dxK7m-0001i0-Ck
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 17:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dxK7l-0006ii-LV
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 17:44:10 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-18-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <cdc20762-b185-25fa-e38f-58f2f9c9a0ea@redhat.com>
Date: Wed, 27 Sep 2017 17:43:57 -0400
MIME-Version: 1.0
In-Reply-To: <20170913160333.23622-18-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 17/23] qemu-img: Change
 check_empty_sectors() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 09/13/2017 12:03 PM, Eric Blake wrote:
> Continue on the quest to make more things byte-based instead of
> sector-based.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>


Reviewed-by: John Snow <jsnow@redhat.com>
