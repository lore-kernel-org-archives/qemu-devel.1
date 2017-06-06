Received: from eggs.gnu.org ([2001:4830:134:3::10]:45084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIHL2-0000bL-1z
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIHKy-0002du-RW
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIHKy-0002dj-Kq
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:28:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170606151757.32473-1-pbonzini@redhat.com>
Date: Tue, 06 Jun 2017 18:28:03 +0200
In-Reply-To: <20170606151757.32473-1-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Tue, 6 Jun 2017 17:17:57 +0200")
Message-ID: <871sqxjd2k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] docs: create interop/ subdirectory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com, peter.maydell@linaro.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> This is for the future interoperability & management guide.  It includes
> the QAPI docs, including the automatically generated ones, other socket
> protocols (vhost-user, VNC), and the qcow2 file format.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

No objections to adding a bit more structure to docs/ this way.  Can't
say I like the name interop/, though.  Oh well, it's not my bikeshed to
paint :)
