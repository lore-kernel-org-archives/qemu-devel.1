Received: from eggs.gnu.org ([2001:4830:134:3::10]:43108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGjUh-0001gA-VJ
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 04:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGjUe-0005ub-6J
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 04:35:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cGjUe-0005uI-0v
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 04:35:28 -0500
Date: Tue, 13 Dec 2016 09:35:21 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161213093521.GE12730@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481612513-28556-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481612513-28556-1-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v3 0/6] crypto: add HMAC algorithms
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

On Tue, Dec 13, 2016 at 03:01:47PM +0800, Longpeng(Mike) wrote:
> Since QEMU has been supported cryptodev, so it is necessary to support
> more crypto algorithms(i.e. hmac,aead) in QEMU backend.
> 
> This patchset add HMAC algorithms support.

Apart from the build failure with glib 2.28, this patch series
looks fine to me.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
