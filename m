Received: from eggs.gnu.org ([2001:4830:134:3::10]:59124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZyHu-00081S-Ne
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:18:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZyHt-00015U-Rd
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:18:22 -0500
Received: from mail.ispras.ru ([83.149.199.45]:39104)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZyHt-00013z-Kf
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:18:21 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
	<1515756676-3860-5-git-send-email-pbonzini@redhat.com>
	<002101d38b9b$1f730620$5e591260$@ru>
	<80ed7db1-e4b4-923f-5da5-a839d0995ced@redhat.com>
In-Reply-To: <80ed7db1-e4b4-923f-5da5-a839d0995ced@redhat.com>
Date: Fri, 12 Jan 2018 15:18:23 +0300
Message-ID: <002301d38b9f$710329d0$53097d70$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PULL 04/52] hpet: recover timer offset correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: 'Maria Klimushenkova' <maria.klimushenkova@ispras.ru>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 12/01/2018 12:47, Pavel Dovgalyuk wrote:
> > This revision is incorrect.
> > Here is the latest one: https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg01751.html
> 
> _That_ version was posted on 10 Jan.
> 
> _This_ version was posted on 11 Jan.  So this one is the latest one; the
> latest one is wrong too.

That's strange.
I posted this version on 20 Dec: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04172.html

Pavel Dovgalyuk
