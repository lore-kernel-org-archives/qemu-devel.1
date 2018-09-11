Received: from eggs.gnu.org ([208.118.235.92]:38259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzgZv-0005mU-P3
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzgZq-0003fL-Kx
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:11:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fzgZl-0003BW-Ph
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:11:22 -0400
References: <20180511081601.14610.39946.stgit@pasha-VirtualBox>
	<377a43be-ec70-f8d0-450e-c71d239685a1@redhat.com>
	<002601d449b8$d1b299a0$7517cce0$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <480acfa6-665a-5377-57d9-2dffa269b617@redhat.com>
Date: Tue, 11 Sep 2018 13:10:56 +0200
MIME-Version: 1.0
In-Reply-To: <002601d449b8$d1b299a0$7517cce0$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ps2: prevent changing irq state on save
 and load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, mst@redhat.com, ciro.santilli@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com

On 11/09/2018 12:18, Pavel Dovgalyuk wrote:
> Paolo, have you forgot about this?
> 
> Pavel Dovgalyuk

Yes, though Gerd might be a better match for the patch.

Paolo
