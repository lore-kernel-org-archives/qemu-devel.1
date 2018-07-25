Received: from eggs.gnu.org ([2001:4830:134:3::10]:46395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fiJCZ-0004NZ-9o
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fiJCW-0005bH-35
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:47:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fiJCV-0005Zt-Oe
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:47:31 -0400
Date: Wed, 25 Jul 2018 08:47:29 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <4226742.54063347.1532522849803.JavaMail.zimbra@redhat.com>
In-Reply-To: <d3fe397a-024d-faf7-8854-bb8e9ea17f53@redhat.com>
References: <20180713075232.9575-1-pagupta@redhat.com>
	<20180713075232.9575-4-pagupta@redhat.com>
	<783786ae-2e85-2376-448c-1e362c3d4d48@redhat.com>
	<399916154.53931292.1532494899706.JavaMail.zimbra@redhat.com>
	<d3fe397a-024d-faf7-8854-bb8e9ea17f53@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3] qemu: Add virtio pmem device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: kwolf@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, nilal@redhat.com, jack@suse.cz, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, kvm@vger.kernel.org, riel@surriel.com, linux-nvdimm@ml01.01.org, david@redhat.com, ross zwisler <ross.zwisler@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, hch@infradead.org, pbonzini@redhat.com, mst@redhat.com, stefanha@redhat.com, niteshnarayanlal@hotmail.com, imammedo@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com




> 
> >>
> >> This patch has no n/M in the subject line; but is included in a thread
> >> that also has a 0/2 cover letter, as well as 1/2 and 2/2 patches in
> >> separate mails.  Is that intentional?
> > 
> > Yes, kernel series has 0-2 patches and Qemu has this one. I thought its
> > good to keep separate numbering for both the sets.
> 
> Ah, that makes sense. The cover letter didn't make it obvious to me that
> this was two separate series to two projects, but related enough that
> both series have to be incorporated for the feature to work and thus
> cross-posted under a single cover letter.

Will try to make it more clear in next posting.

Thanks,
Pankaj
