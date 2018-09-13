Received: from eggs.gnu.org ([2001:4830:134:3::10]:36528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0Rx1-00030T-Od
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0Rx1-0006Iv-3H
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:46:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g0Rx0-0006IJ-R0
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:46:31 -0400
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
	<f6586d6f-54b3-ae20-e9fd-aa0fd5cb4309@redhat.com>
	<000a01d44b67$46df48e0$d49ddaa0$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea318fbd-a036-a153-66fb-692815b3bdf1@redhat.com>
Date: Thu, 13 Sep 2018 15:46:14 +0200
MIME-Version: 1.0
In-Reply-To: <000a01d44b67$46df48e0$d49ddaa0$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/25] Fixing record/replay and adding
 reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net, John Snow <jsnow@redhat.com>

On 13/09/2018 15:40, Pavel Dovgalyuk wrote:
>> For now I'm queuing 12, 14, 19, 20 (pending question to you) and 23-25.
> What about patch 21?

I'd want an ACK from the IDE maintainer.  Let's add him to Cc.

Paolo
