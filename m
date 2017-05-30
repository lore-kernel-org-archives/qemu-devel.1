Received: from eggs.gnu.org ([2001:4830:134:3::10]:36425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFiix-0005hz-6m
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFiis-0004k9-EL
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:06:19 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:36246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFiis-0004jE-7f
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:06:14 -0400
Received: by mail-wr0-x229.google.com with SMTP id j27so2368818wre.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 08:06:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170524150753.GB23327@stefanha-x1.localdomain>
References: <20170524150753.GB23327@stefanha-x1.localdomain>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 30 May 2017 16:06:12 +0100
Message-ID: <CAJSP0QVQe+s5AJOqMgeYX7GrU2FzsFeA9OBN8T3MUebHWm+YZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Status of q35-lite?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>, yang.zhong@intel.com
Cc: Chao Peng <chao.p.peng@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, May 24, 2017 at 4:07 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:

CCing Anthony Xu and Yang Zhong in case they know the current status
of this work.

> Hi Chao,
> Last year there was an effort to make "built-in" hardware optional so
> that VMs can be launched with a minimal set of devices.  You made SATA,
> PIT, and SMBus optional.
>
> What is the current status of this work?
>
> Are there more devices that could benefit from an optional switch?
>
> For reference, here is the discussion that kicked of the effort to make
> some core devices optional:
> "[RFC 0/9] Introduce light weight PC platform pc-lite"
> https://lists.nongnu.org/archive/html/qemu-devel/2016-06/msg04842.html
>
> Stefan
