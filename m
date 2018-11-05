Received: from eggs.gnu.org ([2001:4830:134:3::10]:39968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <v.mayatskih@gmail.com>) id 1gJlB5-0000dy-VH
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 15:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <v.mayatskih@gmail.com>) id 1gJlB5-00064j-Cx
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 15:08:51 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:46330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <v.mayatskih@gmail.com>)
	id 1gJlB5-000643-8F
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 15:08:51 -0500
Received: by mail-qk1-x744.google.com with SMTP id q1so17000698qkf.13
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 12:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20181105140327.8363-1-v.mayatskih@gmail.com>
	<20181105124309-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181105124309-mutt-send-email-mst@kernel.org>
From: Vitaly Mayatskih <v.mayatskih@gmail.com>
Date: Mon, 5 Nov 2018 15:08:38 -0500
Message-ID: <CAGF4SLgyQqnrrfqwnz89f706AjfDyABSWhrfTjEcW=rg5JPN3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/1 resend] Add vhost-pci-blk driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>

On Mon, Nov 5, 2018 at 12:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> I think you should Cc more widely to get meaningful
> review. At least virtio-blk and block layer core people.

Thanks, it turns out I missed the existence of qemu/scripts directory
completely.

-- 
wbr, Vitaly
