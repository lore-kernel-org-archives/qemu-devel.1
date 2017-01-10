Received: from eggs.gnu.org ([2001:4830:134:3::10]:39342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cQpXW-0005JV-7j
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 01:04:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cQpXT-00042g-5O
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 01:04:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:59501)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cQpXS-00042N-Ry
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 01:04:07 -0500
Date: Tue, 10 Jan 2017 14:04:03 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170110060403.ybbmqbcdr3k5wcw3@hz-desktop>
References: <20161109010448.21344-1-haozhong.zhang@intel.com>
	<20161109123520.GF4682@stefanha-x1.localdomain>
	<20161121060023.524bgtem6mqsgacd@hz-desktop>
	<20161121183706-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20161121183706-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2] docs: add document to explain the usage
 of vNVDIMM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 11/21/16 18:38 +0200, Michael S. Tsirkin wrote:
>On Mon, Nov 21, 2016 at 02:00:23PM +0800, Haozhong Zhang wrote:
>> On 11/09/16 12:35 +0000, Stefan Hajnoczi wrote:
>> > On Wed, Nov 09, 2016 at 09:04:48AM +0800, Haozhong Zhang wrote:
>> > > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
>> > > Reviewed-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
>> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > > ---
>> > > Changes since v1:
>> > > * explicitly state the block window mode is not supported (Stefan Hajnoczi)
>> > > * typo fix: label_size ==> label-size (David Alan Gilbert)
>> > > ---
>> > >  docs/nvdimm.txt | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> > >  1 file changed, 124 insertions(+)
>> > >  create mode 100644 docs/nvdimm.txt
>> >
>> > Great.  This patch can go through Michael Tsirkin's tree alongside the
>> > other current nvdimm patches.
>>
>> Hi Stefan and Michael,
>>
>> I noticed that Guangrong's patches had all been checked in. Will this
>> doc patch be included in 2.8?
>>
>> Thanks,
>> Haozhong
>
>Given it was posted after soft freeze, I'd say no.
>Pls remember to ping/repost after the release.
>

Ping, if this one has not been in anyone's tree.

Thanks,
Haozhong
