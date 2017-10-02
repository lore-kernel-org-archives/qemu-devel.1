Received: from eggs.gnu.org ([2001:4830:134:3::10]:47813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dz540-0008JF-Mg
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dz53z-0004uX-W4
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:03:32 -0400
References: <20170930195345.23338-1-eblake@redhat.com>
	<20170930195345.23338-2-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f179607a-3bef-f403-895e-a124bb531fbc@redhat.com>
Date: Mon, 2 Oct 2017 14:03:22 -0400
MIME-Version: 1.0
In-Reply-To: <20170930195345.23338-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] qemu-io: Add -C for opening with
 copy-on-read
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
List-ID: <qemu-devel.nongnu.org>



On 09/30/2017 03:53 PM, Eric Blake wrote:
> Make it easier to enable copy-on-read during iotests, by
> exposing a new bool option to main and open.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
