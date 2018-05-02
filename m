Received: from eggs.gnu.org ([2001:4830:134:3::10]:55005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fDw3L-0005B9-SN
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fDw3L-00004v-5i
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:00:31 -0400
References: <20180421165423.30759-1-mreitz@redhat.com>
	<20180421165423.30759-7-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e2480490-896a-efaa-9345-eb24b1a7a93a@redhat.com>
Date: Wed, 2 May 2018 14:00:17 -0400
MIME-Version: 1.0
In-Reply-To: <20180421165423.30759-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 6/7] iotests: Test help option
 for unsupporting formats
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



On 04/21/2018 12:54 PM, Max Reitz wrote:
> This adds test cases to 082 for qemu-img create/convert/amend "-o help"
> on formats that do not support creation or amendment, respectively.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
