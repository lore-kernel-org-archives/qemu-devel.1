Received: from eggs.gnu.org ([2001:4830:134:3::10]:50835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cJzdi-0004fB-Ed
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cJzdf-0000RD-95
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:26:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cJzdf-0000Qm-33
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:26:15 -0500
Date: Thu, 22 Dec 2016 09:26:08 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161222092608.GH965@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20161221143541.9260-1-berrange@redhat.com>
	<20161221143541.9260-4-berrange@redhat.com>
	<585B2737.8010006@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <585B2737.8010006@huawei.com>
Subject: Re: [Qemu-devel] [PULL v1 3/7] crypto: add HMAC algorithms framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Thu, Dec 22, 2016 at 09:07:03AM +0800, Longpeng (Mike) wrote:
> Hi Daniel,
> 
> Can you pick this patch together ?
> [PATCH for-2.9 v4 1/6] configure: add CONFIG_GCRYPT_HMAC item

Sigh yes. I don't know how i screwed up and missed that patch.

Will send a v2 pull request.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
