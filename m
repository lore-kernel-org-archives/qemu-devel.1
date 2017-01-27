Received: from eggs.gnu.org ([2001:4830:134:3::10]:33638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r3-0005Ae-Jl
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r2-00047D-ME
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:17 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6r2-00046R-G3
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:16 -0500
Received: by mail-wm0-x241.google.com with SMTP id r144so58440755wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:16 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:32 +0100
Message-Id: <1485524749-118532-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/41] doc: fix spelling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

I am pretty sure that's the word Fabrice Bellard intended to write.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index a23a137..34ece80 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3016,7 +3016,7 @@ udp::4555@@:4556} to QEMU. Another approach is to use a patched
 version of netcat which can listen to a TCP port and send and receive
 characters via udp.  If you have a patched version of netcat which
 activates telnet remote echo and single char transfer, then you can
-use the following options to step up a netcat redirector to allow
+use the following options to set up a netcat redirector to allow
 telnet on port 5555 to access the QEMU port.
 @table @code
 @item QEMU Options:
-- 
1.8.3.1
