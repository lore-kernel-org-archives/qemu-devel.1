Received: from eggs.gnu.org ([2001:4830:134:3::10]:51688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cHCZU-0002AU-TT
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:38:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cHCZQ-0006Ni-DB
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:38:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cHCZQ-0006NH-73
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:38:20 -0500
Date: Wed, 14 Dec 2016 16:38:13 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161214163813.GF12972@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481625780-39164-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481625780-39164-1-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v4 0/6] crypto: add HMAC algorithms
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Tue, Dec 13, 2016 at 06:42:54PM +0800, Longpeng(Mike) wrote:
> Since QEMU has been supported cryptodev, so it is necessary to support
> more crypto algorithms(i.e. hmac,aead) in QEMU backend.
> 
> This patchset add HMAC algorithms support.

Thanks, this all looks good, so I've queued this series for 2.9


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
